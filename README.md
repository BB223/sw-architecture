## Converting

The build script in creates docx and pdf output inside ```./build```

```bash
./bin/build.sh
```

<details>

<summary>Manual creating outputs</summary>

## Prerequisites

- pandoc
- ruby
- rubygems
- bundler (gem install bundler)

```bash
bundle config set --local path '.bundle'
bundle install
```

## Asciidoc to docx

### Command

```bash
INPUT_ADOC=arc42-template.adoc
bundle exec asciidoctor -r asciidoctor-diagram --backend docbook --out-file - $INPUT_ADOC| \
pandoc --from docbook --to docx --output $INPUT_ADOC.docx
```

## Asciidoc to pdf

### Command

```bash
bundle exec asciidoctor-pdf -r asciidoctor-diagram arc42-template.adoc
```

</details>
