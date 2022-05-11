# URL Shortener in the Cloud
## What is the mission?
Our marketing partners want to show short, easy to type URLs on the info screen in our vehicles.

## What are you supposed to do?
Provide a REST service that takes a long version of an URL and creates a shortened link.
For example: `https://www.gramann-ahrberg.de/filialen/filialen/ -> moia.io/byos1t34K`

## Acceptance Criteria
* Any URL can be sent to the REST service which will return a shortened URL.
* The shortened URL has a length of 10 characters.
* A shortened URL cannot be duplicated; e.g. two different links won’t provide the same short name.
* The service follows a Serverless architecture using AWS Lambda.

## Supporting information
* To be very economic the needed infrastructure should be able to scale down to zero.
* You can choose your programming language freely. Use whatever you are comfortable with.
* **We don’t expect** you to use your **private AWS account** to create and run this service. We will create a test account for you shortly before our technical interview. In the live session we can use the time to tweak your deployment approach and make your service run.
	* For local development we can recommend [localstack](https://github.com/localstack/localstack) to already validate your setup before the interview.
