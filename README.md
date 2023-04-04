based on [testkube - getting started](https://docs.testkube.io/getting-started/)

## to install via CLI

```shell
./install-testkube.sh
```

## to create a test via CLI on the local machine
 **N.B.** Assumes `testkube` CLI is installed
```shell
testkube create test --file postman_collection.json --type postman/collection --name my-first-test
```

## to see the dashboard

```shell
testkube dashboard
```

-OR- 

```shell
# alias k=kubectl ## see https://kubernetes.io/docs/reference/kubectl/cheatsheet/
# k krew install ns ## assumes krew is installed
k ns testkube
k port-forward svc/testkube-dashboard 8888:8080
k port-forward svc/testkube-api-server 9088:8088
```


#### Tests are just markup files

*e.g.*
```shell
k get test -n testkube my-first-test -o yaml | yq
```

yields

```yaml
apiVersion: tests.testkube.io/v3
kind: Test
metadata:
  creationTimestamp: "2023-04-04T19:27:32Z"
  generation: 1
  labels:
    executor: postman-executor
    test-type: postman-collection
  name: my-first-test
  namespace: testkube
  resourceVersion: "16483"
  uid: 2dbb219b-a5dc-48a5-bb61-4c498f019fc6
spec:
  content:
    data: |-
      {
        "info": {
          "_postman_id": "8af42c21-3e31-49c1-8b27-d6e60623a180",
          "name": "Kubeshop",
          "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
        },
        "item": [
          {
            "name": "Home",
            "event": [
              {
                "listen": "test",
                "script": {
                  "exec": [
                    "pm.test(\"Body matches string\", function () {",
                    "    pm.expect(pm.response.text()).to.include(\"Accelerator\");",
                    "});"
                  ],
                  "type": "text/javascript"
                }
              }
            ],
            "request": {
              "method": "GET",
              "header": [],
              "url": {
                "raw": "https://kubeshop.io/",
                "protocol": "https",
                "host": ["kubeshop", "io"],
                "path": [""]
              }
            },
            "response": []
          },
          {
            "name": "Team",
            "event": [
              {
                "listen": "test",
                "script": {
                  "exec": [
                    "pm.test(\"Status code is 200\", function () {",
                    "    pm.response.to.have.status(200);",
                    "});"
                  ],
                  "type": "text/javascript"
                }
              }
            ],
            "request": {
              "method": "GET",
              "header": [],
              "url": {
                "raw": "https://kubeshop.io/our-team",
                "protocol": "https",
                "host": ["kubeshop", "io"],
                "path": ["our-team"]
              }
            },
            "response": []
          }
        ]
      }
    type: string
  executionRequest: {}
  type: postman/collection
status:
  latestExecution:
    endTime: "2023-04-04T19:28:41Z"
    id: 642c7a3d2ad3d1f1c294385a
    number: 1
    startTime: "2023-04-04T19:27:57Z"
    status: passed
```
