#!/bin/sh
#
#SBATCH --verbose
#SBATCH --job-name=r_job75onestart
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --mem=60GB
#SBATCH --mail-type=END
#SBATCH --mail-user=lh1036@nyu.edu
 
module purge
module load r/intel/3.3.2
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*} 
mkdir -p $RUNDIR

echo $RUNDIR

cp un-model75onestart.R $RUNDIR

cp un_base_workspace.RData $RUNDIR

export RUNDIR

cd $RUNDIR

ls

Rscript un-model75onestart.R $RUNDIR

exit
