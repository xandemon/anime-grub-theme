# Anime GRUB Theme

A minimal anime-inspired GRUB bootloader theme with multiple cool-looking variants.

## Structure

- `base/` - Base theme template with all assets (fonts, icons, UI elements)
- `variants/` - Background images for different theme variants
- `themes/` - **Auto-generated** theme variants (do not edit manually)

## How It Works

This project uses an automated workflow to generate theme variants:

1. **Base Theme** (`base/`) contains the core theme assets and `theme.txt` configuration
2. **Variant Images** (`variants/`) contain background images (jpg, jpeg, or png)
3. **Generated Themes** (`themes/`) are automatically created by combining the base theme with each variant image

### Manual Generation

To generate themes locally:

```bash
./generate-themes.sh
```

This will:
- Create a theme folder for each image in `variants/`
- Copy all base assets to each theme
- Update `theme.txt` to use the variant's background image
- Clean up themes for removed variants

### Automatic Generation (GitHub Actions)

When you push changes to the `main` branch that affect:
- Files in `base/`
- Files in `variants/`
- The generation script or workflow

GitHub Actions will automatically:
1. Generate all theme variants
2. Commit the generated themes to the repository

## Important Notes

⚠️ **Do not manually edit files in `themes/`** - They are auto-generated and will be overwritten.

⚠️ **If you want to modify a theme:**
- Edit files in `base/` to change all themes
- Add/remove images in `variants/` to add/remove theme variants
- The generation script will handle the rest

## Adding New Variants

1. Add your background image to `variants/` (jpg, jpeg, or png)
2. Push to `main` branch
3. GitHub Actions will automatically generate the theme

Or run `./generate-themes.sh` locally to test.

