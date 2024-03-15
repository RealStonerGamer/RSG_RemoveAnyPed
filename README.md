# Remove All Peds

This script allows you to designate coordinates and a radius in the configuration, along with a list of peds to remove from that area. Importantly, it does not remove dead peds, ensuring that animals you've hunted and brought into the area of effect remain unaffected.

## Installation

Follow these simple steps to install:

1. Download the resource.
2. Drag and drop it into the `resources` folder.
3. Add `ensure` or `start <resource_name>` in your `server.cfg` file.

You're all set!

## Usage

To use this script:

- Specify the coordinates `vector3(-295.86, 790.62, 118.46)` and the desired radius in your `Config`.
- Add the ped hashes to your list for the location.

## Debug Mode

If you wish to enable Debug mode, which visualizes the area of effect by displaying the radius, you must have `vorp_utils` installed on your server. `vorp_utils` is required only for Debug mode to function properly. You can find `vorp_utils` here: [vorp_utils GitHub](https://github.com/VORPCORE/vorp_utils).

It's recommended to turn Debug mode off in a live server environment to avoid performance issues or unintended distractions.

