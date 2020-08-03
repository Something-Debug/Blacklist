# Something-Blacklist
A simple FiveM blacklist for vehicles, weapons, and peds.

# FAQ

Q. Can I use ace permissions with this?

A. Yes you can! To use the built in ace permissions add the following to your server.cfg

```
add_ace group.staff Blacklist allow
add_principal identifier.youridentifier group.staff
```
Q. How do I add more vehicles, peds, and weapons to the blacklist?

A. Open sv_blacklist and edit the respective array. Don't forget your commas!

Q. Why are players randomly getting 'Blacklisted Vehicle Model' in the bottom right?

A. The entityCreating event also checks for population move the vehicle into the '_blacklistedVehicles' arrary 

Q. Why doesn't the script work?

A. OneSync is required for this blacklist to work.

Q. Why doesn't xyz work?

A. You messed something up somewhere start from the beginning and try again.

# Support
None, no support will be offered this, resource is simple to set up and is not breakable so long as you follow the format.

# Notes
- More then just vehicles can be added to sv_blacklist props & peds also work.
-In order for the logging to work you need to set a webhook in sv_blacklist.lua
