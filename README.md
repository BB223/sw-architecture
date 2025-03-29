## Converting

### Prerequisites

- [pandoc][1]
- [ruby][2]
- rubygems (installed with ruby)
- bundler (`gem install bundler` if not installed with ruby)
- PlantUML
    - java >= 1.8
    - [graphviz][3]
- [mermaid-cli][4]


```bash
bundle config set --local path '.bundle'
bundle install
```
To generate PDF and DOCX run

```bash
make build
```
To generate only one output run

```bash
make pdf
# or
make docx
```

<details>

<summary>Manual creating outputs</summary>

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

## Mermaid usage

Example:
```asciidoc
[mermaid]
....
---
useMaxWidth: true
---
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop HealthCheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
....
```

## PlantUML usage

Example:
```asciidoc
[plantuml]
....
@startuml
' Include C4-PlantUML definitions (use local copies or remote URLs)
' You only need those that are referenced inside the diagram itself
!include <C4/C4_Context>
!include <C4/C4_Container>
!include <C4/C4_Component>
!include <C4/C4_Dynamic>
!include <C4/C4_Deployment>

' Define your C4 diagram elements
Person(admin, "Administrator", "Manages the system")
System(system, "My System", "The system under observation")

Rel(admin, system, "Uses")

@enduml
....
```

Refer to [PlantUML stdlib][5] for more Libraries

[1]: https://pandoc.org/installing.html
[2]: https://www.ruby-lang.org/en/documentation/installation/
[3]: https://graphviz.org/download/
[4]: https://github.com/mermaid-js/mermaid-cli?tab=readme-ov-file#installation
[5]: https://plantuml.com/stdlib
