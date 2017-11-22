#!/bin/sh
#
#SBATCH --verbose
#SBATCH --job-name=un-analysis-10-30-17
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --time=08:00:00
#SBATCH --nodes=1
#SBATCH --mem=60GB
#SBATCH --mail-type=END
#SBATCH --mail-user=lh1036@nyu.edu
 
module purge
module load r/intel/3.3.2
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*} 
mkdir -p $RUNDIR

echo $RUNDIR

cp un-analysis-tuning.R $RUNDIR

cp un_img_new_dfm.RData $RUNDIR

export RUNDIR

cd $RUNDIR

ls

# srun R CMD BATCH --vanilla un-analysis-cluster.R $RUNDIR

Rscript un-analysis-tuning.R $RUNDIR

exit
