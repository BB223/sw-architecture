# Asciidoc to docx

## Prerequisites

- pandoc
- asciidoctor

## Command

```bash
INPUT_ADOC=arc42-template.adoc
asciidoctor --backend docbook --out-file - $INPUT_ADOC| \
pandoc --from docbook --to docx --output $INPUT_ADOC.docx
```

# Asciidoc to pdf

## Prerequisites

- asciidoctor-pdf

## Command

```bash
asciidoctor-pdf arc42-template.adoc
```
