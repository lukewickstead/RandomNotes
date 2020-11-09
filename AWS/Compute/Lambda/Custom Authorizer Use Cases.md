ntroduction

In the context of the API Gateway, you will need a Custom Authorizer whenever a static IAM policy is not flexible enough for your specific use case, or in case your API consumers can only rely on legacy authentication methods already in place, such as OAuth or SAML.

In these cases, you can secure an API Gateway endpoint by configuring and implementing a special Lambda Function that will take care of generating a custom authorization policy based on the incoming request.

The input of this Lambda Function will be a specific authorization token given by the API consumer. The output will be a cacheable policy document. The API Gateway will evaluate the generated policy, cache it and then proceed with the current request, either denying or allowing access to the configured backend.

Of course, executing the Lambda Function will slow down your API call slightly, but the policy can be cached for up to one hour. The caching mechanism will make sure you don't hit the Custom Authorizer too frequently - and by extension third-party applications as well - resulting in faster API calls.

At runtime, it won't be too different from a standard IAM-based authorization. Know that you can dynamically generate IAM policies based on your own internal logic, including user-based permissions, time-related access, endpoint-based restrictions or any external integration you may think of.


Introduction

A Lambda Custom Authorizer is a normal function that receives as input an authorization token and returns a dynamically generated IAM policy. Assume that you want to integrate API Gateway calls with your custom authentication system using a simple basic authorization mechanism. The following process would occur:

    Clients will call your API with a standard HTTP Authentication header (such as an authorization token).
    API Gateway will invoke the custom authorizer passing the authorization token.
    The custom authorizer will validate the token with your internal auth system (for example via API, reading on an RDS database, and so on).
    Based on the token validation results, a dynamic IAM policy will be generated, by allowing or denying your API endpoints.
    API Gateway will evaluate the given policy to serve the incoming request (and subsequent requests, during a configurable TTL).

The custom authorizer logic is completely up to you: it could be a generic reusable Lambda Function valid for all your API resources or specifically reference API endpoints that you may want to allow or disallow for a given user. For example, you may have different custom roles in your internal system and each role might have access to only a subset of your APIs. This could be achieved with static IAM roles too, but you'd need to bind your internal roles to the corresponding IAM role and keep the two systems in sync. With custom authorizers, you can avoid the synchronization and dynamically check for a given user's role at runtime.