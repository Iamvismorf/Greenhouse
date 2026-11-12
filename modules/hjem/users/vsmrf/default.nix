{utils, ...}: {
  modules.hjem.metadata = {
    hjem.metadata.vsmrf = utils.directoryToAttrs ./_config;
  };
}
