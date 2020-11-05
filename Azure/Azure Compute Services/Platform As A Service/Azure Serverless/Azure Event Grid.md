 ## Azure Event Grid 

- A network to route events between applications
- Route custom events to different endpoints.
- Components:
  - **Events** – The information that happened in the system.
  - **Event sources** – Where the event comes from.
  - **Topics** – It provides an endpoint where the publisher sends events.
  - **Event subscriptions** – Filter the events that are sent to you.
  - **Event handlers** – The service that will process the event.
- You must provide a SAS token or key authentication before publishing a topic.