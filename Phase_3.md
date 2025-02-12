# Phase 3 - Architect

In Phase 2, k3s was used for local container orchestration due to it being a fully compliant, batteries included platform. However, in this Phase, I believe Elastic Kubernetes Service (EKS) would be the better choice due to the managed nature of the orchestration system. It has native support for AWS services such as Application and Network Load Balancers.

We will assume an Application Load Balancer (ALB) is being used as an ingress method into the EKS cluster. One of the [Cloudwatch metrics](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html) for the ALB is `RequestCount`. This meets the requirement.

> The number of requests processed over IPv4 and IPv6. This metric is only incremented for requests where the load balancer node was able to choose a target. Requests that are rejected before a target is chosen are not reflected in this metric.

The RequestCount metric can be configured to have [an alarm associated to it](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html). When the alarm is configured, there are differnt evaluation methods that can be chosen. The simplest would be a basic threshold. If the number of requests goes above a certain number an event can be triggered to perform an action.

For example, The RequestCount alarm could trigger an AWS Lambda to interact with the EKS cluster to perform a scaling operation.

![Diagram showing an AWS environment where a client connects to an application load balancer which is connected to an EKS cluster. A RequestCount metric is monitored in Cloudwatch which is connected to a Lambda which is connected to EKS to trigger a scaling event.](images/EKS.drawio.png)

AWS has a [documented solution](https://aws.amazon.com/blogs/containers/autoscaling-amazon-eks-services-based-on-custom-prometheus-metrics-using-cloudwatch-container-insights/) that follows a similar pattern but an event is triggerd off of a Prometheus metric.

While this option seems reasonable, I am not 100% sure if the Lambda can interact with EKS to perform the scaling event. It may be that EKS has an API which can be triggered. This solution assumes AWS provides these mechanisms.

In order to implement this solution. The following resources need to be created.

- Cloudwatch Alarm with appropriate thresholds
- A Lambda needs to be written and deployed to interact with the EKS cluster
- There will need to be a decision of the cluster is going to scale horizontally or vertically
    - Are more pods needed and/or are more resources needed to handle the load
- Capacity planning needs to be performed to understand what the traffic patterns are
    - This includes when traffic spikes occur as well as the resource pressure the cluster and pods are under

**NOTE**: I have not had time to look into this but there is an assumption that EKS will add more nodes if necessary to handle the either the increase in the number of pods or an increase in the resources (CPU/RAM) the pods will need.

## Scaling Question

I realize the ask is to scale upon number of requests but is that the best approach? By using the request metric, there is an assumption that every request is the same.

- Does each request take about same the amount of time to be serviced?
- Does each request have the same payload size?
- Does each request access the same backends?

While the following documentation refers to Elastic Container Service there are good ideas about what kind of scaling to think about.

- <https://containersonaws.com/presentations/amazon-ecs-scaling-best-practices/>
- <https://nathanpeck.com/amazon-ecs-scaling-best-practices/>
- <https://docs.aws.amazon.com/AmazonECS/latest/developerguide/capacity-autoscaling.html>

## References

- <https://docs.aws.amazon.com/eks/latest/userguide/eks-workloads.html>
- <https://aws.amazon.com/about-aws/whats-new/2023/12/amazon-cloudwatch-alarms-lambda-change-action/>
