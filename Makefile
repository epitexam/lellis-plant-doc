PLANTUML ?= plantuml
SRC_DIR  ?= uml
OUT_DIR  ?= out
FORMATS  ?= png

PUML_FILES := $(shell find $(SRC_DIR) -type f -name '*.puml')

OUT_FILES := $(foreach fmt,$(FORMATS), \
	$(patsubst $(SRC_DIR)/%.puml,$(OUT_DIR)/%.$(fmt),$(PUML_FILES)) \
)

all: check $(OUT_FILES)

help:
	@echo "Usage:"
	@echo "  make"
	@echo "  make check"
	@echo "  make clean"

check:
	@command -v $(PLANTUML) >/dev/null 2>&1 || { echo "ERROR: plantuml not found" >&2; exit 1; }
	@command -v java >/dev/null 2>&1 || { echo "ERROR: java not found" >&2; exit 1; }
	@command -v dot >/dev/null 2>&1 || { echo "ERROR: graphviz (dot) not found" >&2; exit 1; }
	@$(PLANTUML) -version >/dev/null 2>&1 || { echo "ERROR: plantuml cannot run" >&2; exit 1; }
	@$(PLANTUML) -testdot >/dev/null 2>&1 || { echo "ERROR: graphviz not usable by plantuml" >&2; exit 1; }

define GEN_RULE
$(OUT_DIR)/%.$(1): $(SRC_DIR)/%.puml
	@mkdir -p $$(dir $$@)
	@$(PLANTUML) -t$(1) -o $(abspath $(OUT_DIR)) $$<
endef

$(foreach fmt,$(FORMATS),$(eval $(call GEN_RULE,$(fmt))))

clean:
	@rm -rf $(OUT_DIR)

.PHONY: all help check clean
