local is_ok, avante = pcall(require, "avante")
if not is_ok then
    return
end

avante.setup({
    provider = "openai",
    openai = {
        endpoint = "https://one-api.tbanowl.com",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
    }
})
