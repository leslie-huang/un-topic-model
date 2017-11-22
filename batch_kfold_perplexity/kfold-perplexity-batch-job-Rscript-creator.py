import re

with open("kfold_perplexity_base_script.txt", "r") as f:
    base_script = f.read()

    for num in range(40,91):
        temp_script = re.sub("INSERTNUM", str(num), base_script)

        file_name = "kfold_perplexity_{}.R".format(num)

        with open(file_name, "w") as file:
            file.write(temp_script)

with open("base_job.txt", "r") as f:
    base_job = f.read()

    for num in range(40,91):
        temp_job = re.sub("INSERTNUM", str(num), base_job)

        file_name = "R_job_kfold_perplexity_{}.sh".format(num)

        with open(file_name, "w") as file:
            file.write(temp_job)