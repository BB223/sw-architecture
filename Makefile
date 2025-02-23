INPUT_FILE ?= ./arc42-template.adoc

BUILD_DIR ?= ./build

FILENAME := $(notdir $(INPUT_FILE))
BASENAME := $(basename $(FILENAME))

DOCX_OUTPUT := $(BUILD_DIR)/$(BASENAME).docx
PDF_OUTPUT := $(BUILD_DIR)/$(BASENAME).pdf

.PHONY: build build_dir clean pdf docx

build: $(PDF_OUTPUT) $(DOCX_OUTPUT)
	@echo "PDF and DOCX generated in $(BUILD_DIR)"

pdf: $(PDF_OUTPUT)
	@echo "PDF generated in $(BUILD_DIR)"

docx: $(DOCX_OUTPUT)
	@echo "DOCX generated in $(BUILD_DIR)"

$(PDF_OUTPUT): build_dir $(INPUT_FILE)
	bundle exec asciidoctor-pdf -r asciidoctor-diagram $(INPUT_FILE) --out-file $(PDF_OUTPUT)

$(DOCX_OUTPUT): build_dir $(INPUT_FILE)
	bundle exec asciidoctor-pdf -r asciidoctor-diagram --backend docbook $(INPUT_FILE) --out-file - | \
		pandoc --from docbook --to docx --output $(DOCX_OUTPUT)

build_dir:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
	rm -f images/diag*
