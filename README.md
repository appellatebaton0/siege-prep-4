# siege-prep-3
The game I'm making for Hackclub's Siege - Prep Week 3 AND Godot Wild Jam #85

The idea is an autumn-themed game about producing a steady supply of candied apples to meet customer demand.

Additionally, I'll probably add a LOT to the composition framework I've been building on game by game...
## Here's a list of things added for this game thus far;
### General
- DynamicValues -> Allows for node-based glue between components, and for setting up conditions
    - DynamicCondition -> Always returns a bool, for ease of use.
        - DynamicNotValue -> Returns the inverse of a bool DV
        - DynamicAndValue -> Returns if all inputted DVs are true
        - DynamicOrValue -> Returns if any inputted DVs are true
    - DynamicInputValue -> Reads for an input and passes a bool (not a condition in case I need it to return axis strength later)
    - DynamicNodeValue -> Returns a node
        - DynamicComponentValue -> Returns a component from an actor
    - DynamicPropertyValue -> Returns a property from a node
- CMS_Platformer -> Lets an actor be controlled like a platforming character.
- ACP_FuncCaller -> Calls functions on components on collision.
- MS_FuncPlatformer -> Lets an actor be told to move like a platforming character by other nodes
