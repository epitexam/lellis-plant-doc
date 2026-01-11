PLANTUML ?= plantuml
SRC_DIR  ?= .
OUT_DIR  ?= out
FORMATS  ?= png

PUML_FILES := $(shell find $(SRC_DIR) -type f -name '*.puml')
OUT_FILES  := $(foreach fmt,$(FORMATS),$(patsubst $(SRC_DIR)/%.puml,$(OUT_DIR)/%.$(fmt),$(PUML_FILES)))

all: check $(OUT_FILES)

help:
	@echo "Usage:"
	@echo "  make            Generate all PlantUML diagrams"
	@echo "  make check      Verify dependencies"
	@echo "  make clean      Remove generated files"
	@echo "  make help       Show this help"

check:
	@command -v $(PLANTUML) >/dev/null 2>&1 || { echo "plantuml: not found" >&2; exit 1; }
	@command -v dot >/dev/null 2>&1 || { echo "graphviz (dot): not found" >&2; exit 1; }
	@command -v java >/dev/null 2>&1 || { echo "java: not found" >&2; exit 1; }
	@$(PLANTUML) -checkconfig >/dev/null 2>&1 || { echo "plantuml: configuration error" >&2; exit 1; }

$(OUT_DIR)/%.$(FORMATS): $(SRC_DIR)/%.puml
	@mkdir -p $(dir $@)
	@for fmt in $(FORMATS); do \
		$(PLANTUML) -t$$fmt -o $(OUT_DIR) $<; \
	done

clean:
	rm -rf $(OUT_DIR)

.PHONY: all help check clean
