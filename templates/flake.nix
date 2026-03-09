{
  outputs = {...}: {
    templates = {
      qt = {
        path = ./qt;
        description = "cpp project using qt framework";
      };

      cpp = {
        path = ./cpp;
        description = "simple console application";
      };
      shaders = {
        path = ./shaders;
        description = "shaders playground";
      };
    };
  };
}
