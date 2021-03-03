## Instructions to perform load testing in tsung instance

1. install git: sudo yum install git
2. clone AZFanClub repo: git clone https://github.com/scalableinternetservices/AZFanClub.git
3. create 2 polls and 2 users if they aren't present.
4. create a csv file name poll_details.csv having $start_time;$end_time (ensure that the start_time and end_time are valid for the poll)
5. run the following command to loadtest: ./start_load_test.sh $url 80    
