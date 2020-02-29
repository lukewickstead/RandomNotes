# Storage Fundamentals for AWS

## Data Storage Categorisation

- Block Storage
  - Data is stored in chunks known as blocks
  - Blocks are stored on a volume and attached to a single instance
  - Provide avery low latency data access
  - Comparable to DAS storage used in premises
- File Storage
  - Data is stored as separate files with a series of directories
  - Data is stored within a file system
  - Shared access is provided for multiple users
  - Comparable to NAS storage used on premises
- Object Storage
  - Objects are stored across a flat address space
  - Objects are referenced by a unique key
  - Each object can also have associated metadata to help categorize and identify the object
  