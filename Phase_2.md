# Phase 2 - Architect

To give some background, I have not touched Kubernetes in over 5 years. My previous experience was supporting and deploying to a running Kubernetes 1.9.x self hosted cluster at a previous employer. That employer migrated to Elastic Kubernetes Service but I was not involved with that system at all.

My choice here is to go with something lightweight, as requested, but also fully supported by the CNCF. I have also chosen a tool that I have been curious about for some time. I have chosen [k3s](https://k3s.io/).

## Pre-requisites

## Kubernetes

Instsall kubernetes to support non root access. [This documentation](https://dev.to/fransafu/the-first-experience-with-k3s-lightweight-kubernetes-deploy-your-first-app-44ea) was used for reference.

```
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
```

The non root configuration is used because when attempting to deploy a manifest to a k3s cluster that required root, the following error was encountered.

```
error: the path "interview.yaml" cannot be accessed: stat interview.yaml: permission denied
```

### Docker Registry

It will be necessary to store the Docker image in a registry in order to deploy the container properly.

```
docker run -d -p 5000:5000 --restart always --name registry registry:2.8.3
```

The docker registy hostname will be `localhost:5000`

### Push to Registry

The container built from Phase 1 needs to be pushed to this docker registry. The first step that needs to be performed is tagging the image such that it can be pushed to our local registry.

```
$ docker tag platform-interview:0.0.1-SNAPSHOT localhost:5000/platform-interview:0.0.1-SNAPSHOT

$ docker push localhost:5000/platform-interview:0.0.1-SNAPSHOT
The push refers to repository [localhost:5000/platform-interview]
1dc94a70dbaa: Pushed
16e48f601352: Pushed
8812c86dc680: Pushed
5f70bf18a086: Pushed
16c6cbf67a90: Pushed
b32f5a546cd9: Pushed
164179be72d5: Pushed
6763b99e3792: Pushed
9743316173d3: Pushed
4d96b6b9ecca: Pushed
7fbc97c38fad: Pushed
f1122200a9b0: Pushed
ec0381c8f321: Pushed
ec60a3e886a6: Pushed
52efb1a98ceb: Pushed
1eb5983d7301: Pushed
39d381810cef: Pushed
115fc79fb3d1: Pushed
fd93afbbe1ce: Pushed
f92983442b23: Pushed
4d274d05ee12: Pushed
548a79621a42: Pushed
0.0.1-SNAPSHOT: digest: sha256:65e60248c4c96c783a82c359eab08dbeb27b52ff97da402bd6b20d91447e5a08 size: 5117
```

## Deploy Application

```
$ k3s kubectl get svc,pod,deploy
NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/interview    ClusterIP   10.43.211.192   <none>        8090/TCP   2m41s
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP    7m39s

NAME                             READY   STATUS    RESTARTS   AGE
pod/interview-798f74b59d-vvpz6   1/1     Running   0          2m41s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/interview   1/1     1            1           2m41s



$ k3s kubectl logs deployment.apps/interview
Setting Active Processor Count to 2
Calculating JVM memory based on 976836K available memory
For more information on this calculation, see https://paketo.io/docs/reference/java-reference/#memory-calculator
Calculated JVM Memory Configuration: -XX:MaxDirectMemorySize=10M -Xmx379542K -XX:MaxMetaspaceSize=85293K -XX:ReservedCodeCacheSize=240M -Xss1M (Total Memory: 976836K, Thread Count: 250, Loaded Class Count: 12645, Headroom: 0%)
Enabling Java Native Memory Tracking
Adding 137 container CA certificates to JVM truststore
Spring Cloud Bindings Enabled
Picked up JAVA_TOOL_OPTIONS: -Djava.security.properties=/layers/paketo-buildpacks_bellsoft-liberica/java-security-properties/java-security.properties -XX:+ExitOnOutOfMemoryError -XX:ActiveProcessorCount=2 -XX:MaxDirectMemorySize=10M -Xmx379542K -XX:MaxMetaspaceSize=85293K -XX:ReservedCodeCacheSize=240M -Xss1M -XX:+UnlockDiagnosticVMOptions -XX:NativeMemoryTracking=summary -XX:+PrintNMTStatistics -Dorg.springframework.cloud.bindings.boot.enable=true

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.3)

2025-02-12 00:10:21.327  INFO 1 --- [           main] c.l.p.i.PlatformInterviewApplication     : Starting PlatformInterviewApplication using Java 11.0.19 on interview-798f74b59d-vvpz6 with PID 1 (/workspace/BOOT-INF/classes started by cnb in /workspace)
2025-02-12 00:10:21.328  INFO 1 --- [           main] c.l.p.i.PlatformInterviewApplication     : No active profile set, falling back to default profiles: default
2025-02-12 00:10:22.321  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2025-02-12 00:10:22.328  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2025-02-12 00:10:22.329  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.56]
2025-02-12 00:10:22.368  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2025-02-12 00:10:22.369  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 986 ms
2025-02-12 00:10:22.489  INFO 1 --- [           main] .s.s.UserDetailsServiceAutoConfiguration :

Using generated security password: da900e05-20df-4e26-8fe4-900ba406fafb

2025-02-12 00:10:22.525  INFO 1 --- [           main] o.s.s.web.DefaultSecurityFilterChain     : Will secure any request with [org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@3ed34ef5, org.springframework.security.web.context.SecurityContextPersistenceFilter@28bdbe88, org.springframework.security.web.header.HeaderWriterFilter@77114efe, org.springframework.security.web.authentication.logout.LogoutFilter@24d61e4, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@ef60710, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@4288d98e, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@553bc36c, org.springframework.security.web.session.SessionManagementFilter@49d831c2, org.springframework.security.web.access.ExceptionTranslationFilter@4397a639]
2025-02-12 00:10:22.599 DEBUG 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerAdapter : ControllerAdvice beans: 0 @ModelAttribute, 0 @InitBinder, 1 RequestBodyAdvice, 1 ResponseBodyAdvice
2025-02-12 00:10:22.670 DEBUG 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : 4 mappings in 'requestMappingHandlerMapping'
2025-02-12 00:10:22.686 DEBUG 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Patterns [/webjars/**, /**] in 'resourceHandlerMapping'
2025-02-12 00:10:22.691 DEBUG 1 --- [           main] .m.m.a.ExceptionHandlerExceptionResolver : ControllerAdvice beans: 0 @ExceptionHandler, 1 ResponseBodyAdvice
2025-02-12 00:10:22.731  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2025-02-12 00:10:22.743  INFO 1 --- [           main] c.l.p.i.PlatformInterviewApplication     : Started PlatformInterviewApplication in 1.677 seconds (JVM running for 1.908)
```

### Problems

I have been fighting with the Traefik ingress in k3s and I cannot spend anymore time on it. I am missing someting extremely simple where the ingress is not seeing a service port and I am stumped as to what's wrong.

I know the Deployment is working because I can port forward using kubectl to talk to the application.

```
$ kubectl port-forward pod/interview-5474f9c76f-hbxxq 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
```

```
$ curl localhost:8080
Welcome to the Platform team!
```

I found [some documentation](https://dev.to/sklarsa/k3s-traefik-ingress-configured-for-your-homelab-58lc) about needing to config extra ports for Traefik and that gave me some interesting ideas but I still run into the same problems with service issues.

```
time="2025-02-12T02:17:51Z" level=error msg="Skipping service: no endpoints found" namespace=default serviceName=interview servicePort="&ServiceBackendPort{Name:,Number:8080,}" providerName=kubernetes ingress=interview
```

I am very certain that k3s is a great solution as it has an installer process that is cleaner than kind and minikube and out of those three it was the only one that would work with the local docker registry without needing extra configuration. I am lacking the knowledge at this time to get this working correctly.

From my past experience with an Nginx ingress controller, the configuration was relatively straight forward. The DNS name the application needs is configured in the Ingress rules section and the actual DNS name points to the IP address or load balancer that is fronting the Kubernetes cluster.
