import re

with open("perplexity_test_base.txt", "r") as f:
    base_script = f.read()

    for num in range(55,85, 5):
        temp_script = re.sub("INSERTNUM", str(num), base_script)

        file_name = "perplexity_test_{}.R".format(num)

        with open(file_name, "w") as file:
            file.write(temp_script)

with open("base_job.txt", "r") as f:
    base_job = f.read()

    for num in range(55, 85, 5):
        temp_job = re.sub("INSERTNUM", str(num), base_job)

        file_name = "R_job_perplexity_test{}.sh".format(num)

        with open(file_name, "w") as file:
            file.write(temp_job)