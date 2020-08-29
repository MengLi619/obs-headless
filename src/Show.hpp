#pragma once

#include <jansson.h>
#include "Scene.hpp"

typedef std::map<std::string, obs_source_t*> TransitionMap;

class Show {
public:
	Show(std::string id, std::string name, Settings* settings);
	~Show();

	// Getters
	std::string Id() { return id; }
	std::string Name() { return name; }
	SceneMap Scenes() { return scenes; }
	Scene* ActiveScene() { return active_scene; }

	// Methods
	grpc::Status Load(json_t* json_show);
	grpc::Status Start();
	grpc::Status Stop();
	Scene* GetScene(std::string scene_id);
	Scene* AddScene(std::string scene_name);
	Scene* DuplicateSceneFromShow(Show* show, std::string scene_id);
	Scene* DuplicateScene(std::string scene_id);
	grpc::Status RemoveScene(std::string scene_id);
	grpc::Status SwitchScene(std::string scene_id, std::string transition_type, int transition_duration_ms);
	grpc::Status UpdateProto(proto::Show* proto_show);

private:
	std::string id;
	std::string name;
	bool started;
	SceneMap scenes;
	Scene* active_scene;
	Settings* settings;
	uint64_t scene_id_counter;
	TransitionMap transitions;
};

typedef std::map<std::string, Show*> ShowMap;
