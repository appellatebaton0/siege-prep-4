# siege-prep-3
The game I'm making for Hackclub's Siege - Prep Week 3 AND Godot Wild Jam #85

The idea is an autumn-themed game about producing a steady supply of candied apples to meet customer demand.

Additionally, I'll probably add a LOT to the composition framework I've been building on game by game...
## Here's a list of things added for this game thus far;
### General
- CP_Area -> Provides an Area2D for other nodes
	- All existing Area2D Components have become ACPs that work with this instead
- CP_AreaSub -> Superclass for AreaSubComponents(ACP). Provides paths from the AreaComponent's methods.
- ACP_Conveyor -> Moves bodies/areas in collision in a direction.
- ACP_Tooltip -> Shows a Control node at the mouse when the CP_Area is hovered over.
- CP_Holder -> Allows an Actor to hold another one.
- CP_Holdable -> Allows an Actor to be held by another.
- ACP_DragNDrop -> Allows a CP_Holdable to be activated by the mouse.
- ACP_ControlRotate -> Allows an Actor to be rotated when hovered over (configurable input names and degrees)
- MS_Friction -> Sets the actor's velocity to zero unless something is actively trying to move it
- Interface -> Actors but for Controls instead of Node2Ds
- Element -> Components but for Interfaces instead of Actors
- EM_Button -> Element that's literally just a button rn
- BEM_InvSlot -> A fully functional self-contained inventory slot element for actors
- CP_Slotable -> Provides an actor with an ID for inventory slots. Needed to put an actor in an inventory.
- CP_AnimatedSprite -> An animatedsprite with support for syncing globally with others.
- CP_Resource -> Holds any resource for reference by components
- EM_Label -> A dynamic label that can read values from elements and display them
- EM_TextureRect -> A dynamic TextureRect that can display textures from elements and their values (like referenced actors)
- Conditions -> A resource system to dynamically make conditions
	- OR, AND, NOT -> Pretty self explanatory conditions. Allow subconditions.
	- ACTOR -> Lets you see if an actor has a component, and grab *any value from a variable in that component*. 
- ACP_Consumer -> Deletes actors and stores/tracks resources from them (for things like production rates)
- CP_ResourceModifier -> Modifies the value of a resource in a CP_Resource
- CP_Unrotator -> Makes a node's rotation stay constant and ignore the actor's.
- Started on DynamicValues, effectively a system for making glue between components, elements, etc dynamically. Sorta like coding with nodes but it's all data manipulation.
- CP_SFX -> Provides an in for signals to play sfx
- EM_SFX -> See above.
- CP_Particle -> Provides an in for signals to make particles

### Game specific
-  RS_Apple -> A game-specific resource to hold an apple's type, toppings, and glaze.
