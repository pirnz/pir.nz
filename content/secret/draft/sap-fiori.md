```{=org}
#+CREATED: [2021-03-25 Thu 13:23]
```
```{=org}
#+filetags: :netflix:
```
```{=org}
#+hugo_base_dir: ~/ws/kepair.eu
```
```{=org}
#+hugo_section: ./work
```
```{=org}
#+hugo_auto_set_lastmod: t
```
```{=org}
#+hugo_draft: false
```
# SAP Fiori {#sap-fiori-1}

[SAP Fiori Launchpad -- Overview \| SAP Fiori Design
Guidelines](https://experience.sap.com/fiori-design-web/launchpad/): All
sorts of customizations may be available through annotations and
launchpad configurations. That\'s the goal.

# Semantic Objects and Actions

Navigation in Fiori is done with
[intents](https://help.sap.com/viewer/17ae0e97e0fc424a9c368f350c0ba6bd/2.14/en-US/bd8ae3d327ab4541bcce8e7353c046fc.html).

> An intent is a unique combination of a semantic object (for example,
> Purchase Order), an action (for example, Display), and an optional set
> of navigation parameters that are used to define navigation to an
> application.

Intents have the following pattern:

``` html
#<semantic-object>-<action>?<semantic-object-parameter>=<value1>
```

An application can have multiple intents. Each one with [semantic
object](https://stackoverflow.com/questions/41762273/semantic-object-in-sap-fiori)
(an entity), and an action: [SAP Help
Portal](https://help.sap.com/viewer/956efb6db08c450bb303a0d316b72f10/Cloud/en-US/75ef613d7e6b46d0806771a743fbc066.html)

An example:

``` json
"crossNavigation": {
            "inbounds": {
                "intent1": {
                    "signature": {
                        "parameters": {},
                        "additionalParameters": "allowed"
                    },
                    "semanticObject": "MultipleIntent",
                    "action": "display",
                    "title": "{{intent1Title}}",
                    "subTitle": "{{intent1SubTitle}}",
                    "icon": "sap-icon://display"
                },
                "intent2": {
                    "signature": {
                        "parameters": {},
                        "additionalParameters": "allowed"
                    },
                    "semanticObject": "MultipleIntent",
                    "action": "create",
                    "title": "{{intent2Title}}",
                    "subTitle": "{{intent2SubTitle}}",
                    "icon": "sap-icon://create"
                }
            }
        }
    },
```

Using these intents, you can create different tiles in the launchpad:
List Service Orders, Create Service Order... and you can use them to
have intent based navigation from one app to another.

## Configure an action to create an entry

Using intent based navigation, we can navigate from one app to another.
We can also create different shortcuts in a Launchpad that access the
same application: one to access the list report and another that opens
the *create* page.

This idea can be extended: if we have two entities, one with items and
another with orders, we can create a shortcut from the item list to
create an order with previously selected items. This button would
navigate to the previously mentioned *create* page, bringing the items
information and prefilling all related information. This is called
[Create with
Reference](https://experience.sap.com/fiori-design-web/create-with-reference/)
in the UX guidelines. SAPUI5 refers to it when talking about [Prefilling
Fields When Creating a New
Entity](https://sapui5.hana.ondemand.com/sdk/#/topic/11ff444f82e14eb3a2e8eca0065a5055.html).
Here there\'s a distinction between OData V2 and OData V4, and while V4
is not properly documented, V2 says:

> **Creation via Cross-App Navigation** (*for ODataV2*) When navigating
> to an app that is based on SAP Fiori elements, set `parameterMode` or
> `preferredMode` to `create` to indicate that a new instance is to be
> created (and the user starts with the Create screen of this instance).

The behaviour is explained in [Handling of the preferredMode
Parameter](https://sapui5.hana.ondemand.com/sdk/#/topic/bfaf3ccf3d6d4735990cc793b21f5529).
Just what I needed, great! Now the question is, how do I insert that
parameter. There\'s two places where I would want that:

-   **In a Launchpad Tile**: This poses no problem, as when defining a
    tile you can add parameters right when you set the semantic object
    and action.
-   **In another app (cross-app navigation)**: Using a
    `UI.DataFieldForIntentBasedNavigation` as described in [Navigation
    from an App (Outbound
    Navigation)](https://sapui5.hana.ondemand.com/sdk/#/topic/d782acf8bfd74107ad6a04f0361c5f62)
    you create the navigation to another app via intent. However, as
    stated at the bottom of the page \"*Parameters are currently not
    supported*\" in OData V4.

> Applications can define NewAction and its parameters to ensure that
> end users can provide parameter values during creation. For POST based
> creation, a dialog is still shown if there are any non-computed key
> fields or immutable fields. For more information, see Actions.

*[SAPUI5 SDK - Demo
Kit](https://sapui5.hana.ondemand.com/#/topic/11ff444f82e14eb3a2e8eca0065a5055):
Prefilling Fields When Creating a New Entity*

[SAP Fiori Apps Reference
Library](https://fioriappslibrary.hana.ondemand.com/sap/fix/externalViewer/):
This contains demo apps, but no launchpad examples.

# Annotations

With ABAP you can create virtual fields that evaluate to `true` or
`false` to hide elements dinamically: [SAP Help
Portal](https://help.sap.com/viewer/923180ddb98240829d935862025004d6/Cloud/en-US/d840cee5b8f74604ad272a6d4bcb43b7.html)
