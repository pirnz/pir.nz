```{=org}
#+CREATED: [2021-03-25 Thu 13:25]
```
```{=org}
#+FILETAGS: 
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
# Services

> We strongly recommend designing your services for single use cases.
> Services in CAP are cheap, so there's no need to save on them.

[capire - Providing & Consuming Services: Best
practises](https://cap.cloud.sap/docs/guides/services#best-practices)

# Fiori UI

Fiori UI\'s are tied to services and services are design by use cases,
so does this mean I need an app for each thing I want to show in each
service?

# CANCELLED Add Launchpad module

The idea is to add the configuration of apps, groups and roles into the
mta yaml to avoid having to do that manually every time, but adding a
launchpad module creates a portal service instance. I don\'t know what
do do with it after that.

<https://blogs.sap.com/2020/07/18/develop-and-deploy-sapui5-application-with-launchpad-module-from-business-application-studio/>
using yeoman gtenerator with `yo` and using the generator
`@sapflp/generator-launchpad-module`. This generator seems to be only
available through BAS.

This is a boilerplate that adds a portal (?) service instance.

# Authentication and Authorization

Here there\'s everything to secure a CAP service

## Secure service

[capire - Authorization and
Access Control](https://cap.cloud.sap/docs/guides/authorization#restrictions)

Using the annotations:

-   `requires`: To control authentication and anonymous access
-   `restrict`: To control authorization with roles. You can also
    restrict the data accessed based on user info.

``` {.javascript org-language="js"}
@requires: 'functional'
service manageService...
```

``` {.javascript org-language="js"}
entity Orders @(restrict: [
    { grant: 'READ', to: 'Auditor', where: 'country = $user.country' }, //only show info from your country
    { grant: ['READ','WRITE'], where: 'CreatedBy = $user' }, //only edit your own entries
    { grant: ['READ','WRITE'], to: 'admin' }, //role based
  ]) {/*...*/}
```

## Generate xs-security.json

Run this to generate it based on restriction

    cds compile srv/ --to xsuaa > xs-security.json

This will fill in all scopes and role templates, I added role
collections manually.

## Developing locally with secured services

In order to make it easy to develop and test the authorization, you need
a way to handle security locally. You can use `passport` for mock
authentication, or bind the local app to an XSUAA instance.

[capire - Authentication: Mock
authentication](https://cap.cloud.sap/docs/node.js/authentication#mocked)

``` {.javascript org-language="js"}
,
      "auth": {
        "strategy": "mock",
        "users": {
          "alice": {
            "roles": [
              "admin",
              "requester"
            ]
          },
          "bob": {
            "roles": [
              "requester"
            ]
          },
          "sofia": {
            "roles": [
              "functional",
              "lead",
              "requester"
            ]
          },
          "franz": {
            "roles": [
              "functional",
              "requester"
            ],
            "userAttributes": {
              "subsolutions": [
                "Talent Acquisition"
              ]
            }
          },
          "*": true
        }
      }
```

To disable security temporarily, change `"strategy"` from `"mock"` to
`"dummy"` in `package.json` under `cds.requires.auth`.

## Instance-Based Authorization

[capire - Authorization and
Access Control](https://cap.cloud.sap/docs/guides/authorization#instance-based-auth)

Using user attributes to manage permissions when using
`@requires ... where 'createdBy=$user'` has certain limitations when
using associations and 1:n relationships.

To implements checks like:

-   Ability to manage deliveries where the user is an assignee:
    `assignee.userid=$userid`
-   Ability to manage portfolio items from specific solutions or
    subsolutions: `subsolution=$user.subsolution`

the best options is to set *before* handlers and perform the check
there.
