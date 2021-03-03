import uuid

ROWS=10000

UUID_SET = set()

while(len(UUID_SET)<ROWS):
    UUID_SET.add(uuid.uuid4())

with open('poll_seed.csv', 'w') as f:
    for i in range(ROWS):
        poll_details = [str(UUID_SET.pop()), "Poll_{}".format(i), "2021-03-02 00:00:00", "2021-03-05 23:59:59", "9", "23"]
        f.write(';'.join(poll_details)+'\n')

