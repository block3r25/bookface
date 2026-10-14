# Design Specification: Facebook Splash Screen

## 1. Overview

A minimalist mobile splash screen for the Facebook app, shown on a white
background with the Facebook logo centered vertically in the main
content area. Meta branding appears near the bottom, with a separate
dark attribution bar along the bottom edge.

## 2. Canvas and Layout

-   **Reference format:** Tall, portrait mobile screenshot.
-   **Approximate aspect ratio:** 9:16.
-   **Background:** Solid white (`#FFFFFF`) across the main screen.
-   **Composition:** Spacious and symmetrical, with substantial empty
    space around the central logo.
-   **Safe areas:** Preserve the system gesture/navigation area above
    the bottom attribution strip.

## 3. Main Brand Mark

-   **Element:** Facebook "f" logo inside a blue circle.
-   **Placement:** Horizontally centered; positioned slightly below the
    vertical midpoint of the white content area.
-   **Approximate scale:** Circle occupies about 19% of the canvas
    width.
-   **Color:** Facebook blue, approximately `#3978E8`; white lowercase
    "f" symbol.
-   **Treatment:** Flat, clean vector-like mark with crisp edges and no
    visible shadow or outline.

## 4. Meta Signature

-   **Placement:** Centered near the bottom of the white area, above the
    attribution bar.
-   **Content hierarchy:**
    1.  Small gray text: "from"
    2.  Blue Meta infinity symbol and "Meta" wordmark on the next line
-   **Typography:** Modern sans-serif; "from" is regular-weight and
    muted gray, while the Meta wordmark is blue and visually stronger.
-   **Spacing:** Compact vertical gap between "from" and the Meta logo.

## 5. System Navigation Area

-   **Element:** Horizontal gesture/navigation indicator.
-   **Placement:** Centered close to the bottom of the white area, just
    above the dark attribution bar.
-   **Appearance:** Short, rounded gray line on white.
-   **Approximate color:** `#9B9B9B`.

## 6. Bottom Attribution Bar

-   **Placement:** Full width, flush to the bottom of the image.
-   **Height:** Approximately 7% of the total canvas height.
-   **Background:** Dark charcoal (`#292929`).
-   **Left group:** Small Facebook app icon followed by the white label
    "Facebook".
-   **Right group:** White "curated by" text followed by the white
    Mobbin wordmark.
-   **Alignment:** Both groups are vertically centered and arranged on
    one horizontal line, with generous separation.
-   **Padding:** Consistent horizontal inset from both edges.
-   **Typography:** Bold or semibold sans-serif, sized for clear
    legibility on a mobile screen.

## 7. Color Palette

  Role              Approximate color   Usage
  ----------------- ------------------- ----------------------------------
  Main background   `#FFFFFF`           Splash screen background
  Facebook blue     `#3978E8`           Facebook logo and Meta branding
  Primary white     `#FFFFFF`           Logo glyphs and attribution text
  Muted gray        `#75818D`           "from" label
  Navigation gray   `#9B9B9B`           Gesture indicator
  Charcoal          `#292929`           Bottom attribution bar

## 8. Typography

-   Use a clean contemporary sans-serif family.
-   Keep the central splash area free of extra copy.
-   Use white, high-contrast text in the bottom bar.
-   Match the screenshot's compact, bold label styling rather than
    introducing decorative type.

## 9. Responsive Behavior

-   Keep the Facebook logo centered horizontally at all portrait screen
    sizes.
-   Position the Meta signature toward the lower part of the white area,
    maintaining a clear gap from the central logo.
-   Anchor the attribution bar to the bottom edge and keep it full
    width.
-   Use flexible spacing so the layout remains balanced on taller or
    shorter screens.
-   Respect device safe areas and avoid overlapping the gesture
    indicator with the attribution bar.

## 10. Visual Style and Constraints

-   Minimal, brand-led, flat design.
-   Large negative-space regions are intentional and should be
    preserved.
-   Avoid gradients, textures, extra shadows, cards, borders, or
    additional interface controls.
-   Keep the layout uncluttered and close to the supplied reference.
-   Treat the dimensions and color values as visual estimates from the
    screenshot, not official brand specifications.
