SERVICES_DIR := ./services
CONNECTORS_DIR := ./connectors

# Take care, if you change it, modify the driver_opts in corresponding services
PERSISTENT_VOLUMES_DIR := ./opencti_persistent_volumes

SERVICES_FILES := $(wildcard $(SERVICES_DIR)/service-*.yml)
SERVICES_FILES_FLAGS := $(foreach file, $(SERVICES_FILES), -f $(file))

CONNECTOR_FILES := $(wildcard $(CONNECTORS_DIR)/connector-*.yml)
CONNECTOR_FILES_FLAGS := $(foreach file, $(CONNECTOR_FILES), -f $(file))

ENVS_DIR := ./envs
ENVS_FILES := $(wildcard $(ENVS_DIR)/*.env)

UNAME := $(shell uname)
UUID_GEN := `cat /proc/sys/kernel/random/uuid`

ifeq ($(UNAME), Darwin)
	UUID_GEN := `uuidgen`
endif

#Function to replace all `# <generate_uuid>` with the UUID_GEN command
define generate_uuids
	echo "Replacing UUID in $(1)...";
	grep "# <generate_uuid>" $(1) | while read -r line; do \
		key="$$(echo $$line | cut -d '=' -f 1)"; \
		sed -i '' "s/$$line/$$key=$(UUID_GEN) # <generate_uuid>/g" $(1); \
	done;
	echo "All UUID replaced in $(1).";
endef


#Initial Install OpenCTI
opencti-install:
	@echo "Creating Databases structures if needed..."
	@mkdir -p $(PERSISTENT_VOLUMES_DIR)/{s3data,redisdata,amqpdata,esdata}
	@echo "Starting installation by settings all new UUID..."
	@$(foreach file, $(ENVS_FILES), $(call generate_uuids, $(file)))
	@echo "Installation done..."

# Up OpenCTI
opencti-up:
	@echo "Building Environments..."
	@> .env
	@cat ./envs/*.env >> .env
	@echo "Starting services and connectors..."
	@docker-compose --project-name opencti $(SERVICES_FILES_FLAGS) $(CONNECTOR_FILES_FLAGS) --env-file .env up -d
	@echo "OpenCTI should be running"

# Down OpenCTI
opencti-down:
	@echo "Stopping services..."
	@docker-compose --project-name opencti $(SERVICES_FILES_FLAGS) $(CONNECTOR_FILES_FLAGS) down -v

# Logs
opencti-logs:
	@echo "Access all docker-compose logs..."
	@docker-compose --project-name opencti $(SERVICES_FILES_FLAGS) $(CONNECTOR_FILES_FLAGS) logs -f -t --tail=1000

# Remove OpenCTI
opencti-docker-prune:
	@make opencti-down
	@echo "Hard deleting all databases..."
	@rm -rf $(PERSISTENT_VOLUMES_DIR)/*
	@echo "Cleaning Docker (prune af)..."
	@docker system prune -af
