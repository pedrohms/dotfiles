local status_ok, projectnvim = pcall(require, "project_nvim")
if status_ok then
    projectnvim.setup {}
    local status_telescope, telescope = pcall(require, "telescope")
    if status_telescope then
        telescope.load_extension('projects')
    end
end
