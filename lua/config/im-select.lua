local is_ok, im_select = pcall(require, 'im_select')
if not is_ok then
    return
end

im_select.setup({
    default_im_select = "com.apple.keylayout.ABC"
})
