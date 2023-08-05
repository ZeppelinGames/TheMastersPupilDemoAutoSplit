state("TheMastersPupil-Final-Demo") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    vars.Watch = (Action<string>)(key => { if(vars.Helper[key].Changed) vars.Log(key + ": " + vars.Helper[key].Old + " -> " + vars.Helper[key].Current); });
}

init {
    vars.reset = false;
}

reset {
    if(vars.reset) {
        if(current.loadingScene == "Scene1") {
            vars.reset = false;
            return true;
        }
    }
}

start {
    if(current.activeScene == "Scene1") {
        return true;
    }
}

update {
    current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name == null ? current.loadingScene : vars.Helper.Scenes.Loaded[0].Name;
}

split {
    if(old.loadingScene != current.loadingScene) {
        vars.reset = true;
        return true;
    }
    return false;
}

isLoading
{
    return current.activeScene != current.loadingScene;
}