# proton-standalone
run non-steam games with Proton and the Sniper runtime without messing everything up.
it's called proton-standalone despite very much depending on Steam files by default, not hard to just throw those somewhere else and change the paths in proton-standalone.sh though.
very easy to divorce Proton and Sniper from Steam and use them with proton-standalone without issue if you want to, not much of a reason to do so if Steam is already installed though.

you should probably just use [umu](https://github.com/Open-Wine-Components/umu-launcher) unless you very particularly want the most minimal way of using Proton and Sniper with non-Steam games. expect this to not work down the line, will likely require you to change the "sniper_version" variable at some point in time. Don't use this unless you *really* want to use the exact version of Proton and Sniper runtime that Steam comes with to run non-Steam games.

you have been warned.
