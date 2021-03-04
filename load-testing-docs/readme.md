## Instructions for deployment
1. Deploy normally by following the code snippets on `cs291.com`
2. SSH into the deployed instance using `eb ssh <ENV name>`
3. The following commands will reset the database (effectively seeding it)
```
cd /var/app/current/load-testing-docs
sudo ./seed_database.sh
```

## Instructions to perform load testing in tsung instance

1. install git: sudo yum install git
2. clone AZFanClub repo: git clone https://github.com/scalableinternetservices/AZFanClub.git
3. run the following command to loadtest: ./start_load_test.sh $url 80
