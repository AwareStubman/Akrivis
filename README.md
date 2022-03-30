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

### Fullscreen passes
1. composite
   - Bloom tile generation + 1 pass gaussian blur to them, 7 tiles
2. composite1
   - averaging of all 7 bloom tiles, then applied to the whole screen