#!/bin/sh
#
#SBATCH --verbose
#SBATCH --job-name=un_k_66
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --mem=32GB
#SBATCH --mail-type=END
#SBATCH --mail-user=lh1036@nyu.edu
 
module purge
module load r/intel/3.3.2
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*} 
mkdir -p $RUNDIR

echo $RUNDIR

cp un-find66.R $RUNDIR

cp un_base_workspace.RData $RUNDIR

export RUNDIR

cd $RUNDIR

ls

Rscript un-find66.R $RUNDIR

exit
