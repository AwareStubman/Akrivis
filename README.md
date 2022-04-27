# Akrivis
The name is the greek word for "Accurate", but don't let that fool you, this repo is merely my own shader playground for Minecraft, and it may or may not be accurate at all.
Plus, what does it even mean by "accurate"? Probably realism, but I'll just leave it at that.

# What is this?
This is a shader made for the Optifine mod (and probably Iris, but I doubt) for Minecraft. Made on Minecraft 1.17.1 with HD H2_pre1 version of Optifine.

# Inner workings
### Buffer management
- colortex0
  - Main buffer, can contain anything that will be displayed to the screen
- colortex10
  - Bloom tiles

### Gbuffer passes
1. gbuffers_terrain
   - Discard transparent fragments
   - Convert albedo to Linear sRGB
   - Apply LabPBR emissives
### Fullscreen passes
1. composite
   - Convert sky's color space from sRGB to Linear sRGB
2. composite1
   - Bloom tile generation + 1 pass gaussian blur to them, 5 tiles
3. composite2
   - averaging of all 5 bloom tiles, then applied to the whole screen
4. final
   - Apply tonemap and Linear->sRGB conversion + post processing