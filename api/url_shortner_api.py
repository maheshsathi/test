import json
from hashids import Hashids

def lambda_handler(event, context):
           """ This lambda handler converts long url as short url.

           request: {
               long_url:"http://sample-request/"
           }
           
           """
           json_data = json.loads(event["body"])

           # If no json request provided, return internal server error
           if json_data is None:
                return generate_bad_response("Internal Server Error",500)
    
           else:
                if 'long_url' in json_data:

                    # Extract long_url from json request
                    long_url = json_data["long_url"]

                    # Hashids generates short unique ids from strings
                    hashid_s = Hashids(salt=long_url, min_length=10)

                    # Replace symbols (.,:,/) from url
                    long_url = long_url.replace(".","")
                    long_url = long_url.replace(":","")
                    long_url = long_url.replace("/","")

                    length = len(long_url)

                    # Generate short url
                    short_url = long_url[length-5:] +".io/" + hashid_s.encode(12)
                    
                    result = { 'statusCode':200,
                                'body': json.dumps({
                                    'short_url':short_url,
                                    'success':True,
                                    'message':"",
                                    'code':200
                        })
                    }
                    return result


# Generates server error response
def generate_bad_response(message,code):
    response = {
        'statusCode':code,
        'body': json.dumps({
            'success':False,
            'message':message,
            'code':code
            })
    }
    return response