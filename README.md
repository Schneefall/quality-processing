# Introduction

This mod is for everyone who feels the vanilla way of making quality items - throwing a lot of materials into a recycling loop for a percentage change of an upgrade - does not fit factorio or has become boring. I quite liked the idea behind [Promethium is Quality](https://mods.factorio.com/mod/promethium-quality), having a machine that guarantees an upgrade at the scaled cost of some other material, promethium in that case. However, it is only available in endgame, so it is not an alternative to earlier quality upgrades. [Quality condenser](https://mods.factorio.com/mod/quality-condenser) is available early on and essentially compresses the recycling loop into a single machine, but still stays true to the vanilla process of throwing a lot of ingredients at the problem.

In the end, I took to the idea of Promethium is Quality, but implemented a dedicated upgrade process for each vanilla quality level, complete with new machines, items, and crafting chains, hoping to bring a more factorio-like feel to the quality system throughout the game.


# Content

This mod introduces 5 quality upgrade machines and crafting chains for their associated upgrade materials, which become more complicated with each quality level. Each machine can upgrade any item's quality to its level by consuming a number of upgrade items depending on the upgraded item's complexity. By default the upgrade will only work for one quality level and the upgrade item has to match the input in quality. The quality levels have been renamed to match the theme of the mod.

## Standardization

The Standardizer can reset an item's quality back to Standard (Normal) by using only some sulfuric acid.
Standardization research requires quality modules.

## Post Processing

The Post Processor uses Post Processing Kits and some water to upgrade Standard items to Processed (Uncommon).
Post Processing Kits can be crafted anywhere from stone, advanced circuits, and lubricant.
Post Processing can be researched after electric engines and requires chemical science.

## Calibration

The Calibrator uses Calibration Matrices to upgrade Processed items to Calibrated (Rare). The upgrade process will fail if the input is of lower quality.
Calibration Matrices are crafted from Calibration Sensors and Calibration Housing. 
The housing can be crafted anywhere, but the sensors require a micro gravity environment and must be crafted in space.

## Reinforcement

The Reinforcer uses Reinforcement Packages to upgrade Calibrated items to Reinforced (Epic).
It is available after Fulgora, Vulcanus, and Gleba and requires epic quality research.
The components of the reinforcement package (Electronic reinforcement, Structural reinforcement, Bioreinforcement) also come from these planets.

## Quantum Tuning

The Quantum Calibrator uses Quantum Tuners to upgrade Reinforced items to Tuned (Legendary).
As the final stage, quantum tuning requires promethium science and quantum tuners are crafted on Aquilo, while requiring components from earlier planets.
Quantum tuners are also unstable and will decay (spoil) after some time.


# Settings

There are several setting to tweak the mod's difficulty:

- Upgrade material crafting can be simplified by removing surface conditions or intermediate products.
- Upgrading can be made entirely free (if you feel you need this).
- Some higher level upgrade materials can spoil. The spoil time can be modified or disabled entirely.
- The necessity of multi-step upgrades can be disabled, allowing to upgrade from Standard to Tuned in one step.
- The complexity measure that determines the upgrade cost can be tweaked in a number of ways.
- Vanilla quality modules can be hidden.
- Items can be blacklisted from the upgrade machines.


# Compatibility

- Not compatible with mods that remove the original quality levels.
- Mods that add more quality levels after legendary should be compatible, but this mod only provides upgrade processes for the original quality levels. Use at your own risk.
- Should be compatible with mods that modify quality effects.
- The vanilla quality mechanics (quality modules, upgrade chances) remain untouched.
- Quality level renaming is included.


# Known Issues

- If an upgrade craft finishes within one tick the quality upgrade will fail. This is a technical limitation. The minimum upgrade time of 5s should make this impossible for vanilla factorio, but if you encounter this issue, you can increase the "Minimum upgrade time" setting to get slower bulk recipes.
- Higher levels of upgrades (epic, legendary) have not been tested in normal gameplay.


# Credits

- Crafting machine graphics by [Hurricane046](https://mods.factorio.com/user/Hurricane046) (CC-BY)
- Item icons by [malcolmriley](https://github.com/malcolmriley/unused-renders) (CC-BY-4.0)
- Item complexity calculation heavily insipred by [Promethium is Quality](https://mods.factorio.com/mod/promethium-quality) (MIT)
- [Customizable Quality Names](https://mods.factorio.com/mod/customizable-quality-names) by Wiwiweb is included (MIT)
