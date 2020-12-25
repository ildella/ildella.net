# ildella.net

[![Netlify Status](https://api.netlify.com/api/v1/badges/fc255ca7-ff60-4785-8d62-e1a695b94875/deploy-status)](https://app.netlify.com/sites/ildellanet/deploys)

Personal site and blog about software development, computer and networks.

## Code 

```shell
git clone --recurse-submodules git@github.com:ildella/ildella.net.git
```

or a simple `clone` and then

```shell
git submodule update --init --recursive
```

## Start

```shell
yarn
yarn start
```

## Blog

Full [command docs](https://hexo.io/docs/commands)

```shell
hexo new [layout] <title>
```

## Working with theme in submodule

Remember to call `yarn update-theme` to get the latest theme code from the **remote** repository. 

The workflow to change the theme is:

1. clone the theme repo
2. make the changes, without of course knowing what is going on in real time
3. push the changes
4. call `yarn update-theme` to see the results. 

LOL, of course this is crazy, but something non-trivial should be done to make changes to the theme and see them live in your local dev environment. 
