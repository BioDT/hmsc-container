from hmsc.run_gibbs_sampler import run_gibbs_sampler


nSamples = 100
thin = 2
verbose = 100
transient = nSamples * thin

run_gibbs_sampler(
    num_samples=nSamples,
    sample_thining=thin,
    sample_burnin=transient,
    verbose=verbose,
    init_obj_file_path="init_file.rds",
    postList_file_path="post_file.rds",
    rng_seed=0,
    hmc_leapfrog_steps=10,
    hmc_thin=0,
    flag_update_beta_eta=False,
    flag_save_eta=True,
    flag_profile=False,
)
