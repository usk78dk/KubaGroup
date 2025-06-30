# KubaGroup
Technical assignment for Kuba Group, June 2025

Despite being overkill for this task, I tried to implement some of the ways I like an app to work.

There's no navigation in this project, but I have added an AppCoordinator so it's ready for that. I always like to keep the navigation out of the individual View Controllers.

I added a repository, to have a centralised place to keep the API calls etc.. This makes it very easy to test new versions of the APIs out, without having to update the code elsewhere. Just initialise the service with a different repository (dependency injection).

Also added the a service, where business logic and error handling should be - again so it's easy to test out other services and you just change the service in the AppDelegate. 


The search bar could have been implemented as a navigation item or the view controller as a UISearchContainerViewController, which might have been more obvious. However, for the sake of the task I thought it showed more to implement it this way.
