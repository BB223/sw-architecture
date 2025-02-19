## Converting

The build script in creates docx and pdf output inside ```./build```

```bash
./bin/build.sh
```

<details>

<summary>Manual creating outputs</summary>

## Asciidoc to docx

### Prerequisites

- pandoc
- asciidoctor
- asciidoctor-pdf
- asciidoctor-diagram

### Command

```bash
INPUT_ADOC=arc42-template.adoc
asciidoctor -r asciidoctor-diagram --backend docbook --out-file - $INPUT_ADOC| \
pandoc --from docbook --to docx --output $INPUT_ADOC.docx
```

## Asciidoc to pdf

### Prerequisites

- asciidoctor-pdf

### Command

```bash
asciidoctor-pdf -r asciidoctor-diagram arc42-template.adoc
```

</details>
