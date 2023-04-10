# urban-fortnight

[![Build Status](https://dev.azure.com/AzCelerium/CeleriumDemo/_apis/build/status%2FCelerium._CeleriumDemo?branchName=main)](https://dev.azure.com/AzCelerium/CeleriumDemo/_build/latest?definitionId=3&branchName=main)

Just a test repo to better understand Git test



```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```

````
```mermaid
sequenceDiagram
    participant dotcom
    participant iframe
    participant viewscreen
    dotcom->>iframe: loads html w/ iframe url
    iframe->>viewscreen: request template
    viewscreen->>iframe: html & javascript
    iframe->>dotcom: iframe ready
    dotcom->>iframe: set mermaid data on iframe
    iframe->>iframe: render mermaid
```
````

```mermaid
sequenceDiagram
    participant dotcom
    participant iframe
    participant viewscreen
    dotcom->>iframe: loads html w/ iframe url
    iframe->>viewscreen: request template
    viewscreen->>iframe: html & javascript
    iframe->>dotcom: iframe ready
    dotcom->>iframe: set mermaid data on iframe
    iframe->>iframe: render mermaid
```
