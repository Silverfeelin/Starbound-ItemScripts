# Item Scripts
Simple structure to allow any number of active items to use their own custom scripts, by having a vanilla script load the custom script (if present). This makes it easy to set up custom items that don't crash other players when they pick up the item.

## Usage

* Optional: Create a mod. You can also choose to put your script into `/assets/user/` or a mod folder you already have.
* Create your custom item script. The format is the same as any other active item script; you can set up the `init`, `update`, `uninit` and/or `activate` functions, and write your own code.
* Set up an item that uses your custom script. I prefer using spawn commands, but you could also set up a recipe or an item descriptor for external inventory editors. In the below example, I placed the script in `/assets/user/scripts/myScript.lua`.
* Test! Before visiting servers with your multiplayer compatible items, I always suggest first testing your item offline to ensure it works like you'd expect.

#### Sample Item

```
/spawnitem fossilbrushbeginner 1 '{"itemScript":{"script":"/scripts/myScript.lua"}}'
```

#### Sample Script

```lua
function init()
  sb.logInfo("My script initialized!")
end
```

#### Sample Result

```
[12:42:54.478] [Info] My script initialized!
```

## How it works

By setting a custom parameter on your item, you can change the script it uses. The actual script the item loads remains `/items/active/fossil/fossilbrush.lua`, which prevents problems on servers.

The `fossilbrush.lua` has been modified to call a script loader, which reads this custom parameter. If it is present, the mod attempts to load the new script and make the item behave according to this script. If the script can not be found, you will experience a freeze for about a second the first time, and after that nothing out of the ordinary will happen when you hold the item. Although I wish the freeze could be eliminated, that does not appear to be the case. This does solve item crashes that can lead to character corruption.

It is important to note that any items that do not have the `itemScript` parameter will behave normally; as if the script loader wasn't there.

Result of a missing custom script for an item:

![](https://raw.githubusercontent.com/Silverfeelin/Starbound-ItemScripts/master/readme/error.png)  

Result of a missing custom script for an item using ItemScripts:

```
[12:12:27.093] [Warn] ItemScript: Could not load the script '/scripts/someScript.lua'.
```

## Using other items

As described before, the fossil brush script was modified to use the scriptloader. I chose this script as it is not used by a lot of items, and seemed to be the best script to modify while staying compatible with most other mods.

You can make other active item scripts use the script loader by adding the below code to the start of the `init` function.

```lua
require "/scripts/itemScriptLoader.lua"
if itemScript then return end
```
