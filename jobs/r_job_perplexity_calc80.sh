#!/bin/sh
#
#SBATCH --verbose
#SBATCH --job-name=un-perplexitycalc80
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --mem=30GB
#SBATCH --mail-type=END
#SBATCH --mail-user=lh1036@nyu.edu
 
module purge
module load r/intel/3.3.2
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*} 
mkdir -p $RUNDIR

echo $RUNDIR

cp perplexity_calc80.R $RUNDIR

cp perplexity_base.RData $RUNDIR

export RUNDIR

cd $RUNDIR

ls

Rscript perplexity_calc80.R $RUNDIR

exit
