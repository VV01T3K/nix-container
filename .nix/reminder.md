# Managing Flake.nix Changes

When working with `flake.nix`, remember these important points:

1. All changes to `flake.nix` must be committed to git before:
   - Updating flake inputs
   - Running `nix flake update`
   - Changing flake directory location

2. Common workflow:
```bash
# Stage and commit flake changes
git add flake.nix
git commit -m "update: flake configuration changes"

# Then you can run flake commands
nix flake update
```

3. If you need to move the flake directory, ensure:
   - All changes are committed
   - Update any references to the flake path in your project
   - Update the flake registry if you've registered your flake locally