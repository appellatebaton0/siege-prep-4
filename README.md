# siege-prep-4
The game I'm making for Hackclub's Siege - Prep Week 4

The idea is a game where you tell a platformer what to do by placing blocks in its path that give it commands

And, more building to the framework!
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
