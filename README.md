# paper-pile

A Quarto shortcode extension for [Reveal.js](https://quarto.org/docs/presentations/revealjs/) presentations that drops a stack of images ("screenshots", scanned papers, article thumbnails, etc.) onto the slide with a spinning newspaper-style entrance.

The first image spins in automatically as soon as its slide becomes current. Every image after that is a Reveal fragment, so it spins in on its own subsequent "next" step.

## Installing

```bash
quarto add nickriches/quarto-paper-pile
```

This installs the extension under `_extensions/paper-pile` in your project. No further setup is required — the extension registers its own CSS and JS automatically wherever the shortcode is used.

## Using

```markdown
{{< paper-pile "paper1.png" "paper2.png" "paper3.png" >}}
```

Image paths are relative to the `.qmd` file, same as a normal Markdown image.

### Options

| Option    | Default  | Description                                             |
|-----------|----------|-----------------------------------------------------------|
| `stagger` | `0.4`    | Seconds between each paper's spin-in delay.                |
| `height`  | `560px`  | Height of the `.paper-pile` container.                     |

```markdown
{{< paper-pile "paper1.png" "paper2.png" stagger=0.6 height=600px >}}
```

## Notes

- Designed for `revealjs` output. On non-HTML formats (e.g. a `pptx` target in the same document) it falls back to a plain stack of images rather than emitting unusable HTML/JS.
- Positions, rotation and stagger delay for each paper are computed by the shortcode itself and applied as inline styles, so any number of images works — not just two or three.

## Example

See [`example.qmd`](example.qmd) for a minimal working deck. Render it with:

```bash
quarto render example.qmd
```
