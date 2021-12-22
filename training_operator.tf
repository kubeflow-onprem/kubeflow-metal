data "kustomization_build" "training_operator" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/training-operator/upstream/overlays/kubeflow"
}

resource "kustomization_resource" "training_operator_manifests_priority_1" {
  for_each = data.kustomization_build.training_operator.ids_prio[0]

  manifest = data.kustomization_build.training_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_controller_manifests_priority_1,
    kustomization_resource.tensorboard_controller_manifests_priority_2,
    kustomization_resource.tensorboard_controller_manifests_priority_3
  ]
}

resource "kustomization_resource" "training_operator_manifests_priority_2" {
  for_each = data.kustomization_build.training_operator.ids_prio[1]
  manifest = data.kustomization_build.training_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.training_operator_manifests_priority_1,
    kustomization_resource.tensorboard_controller_manifests_priority_1,
    kustomization_resource.tensorboard_controller_manifests_priority_2,
    kustomization_resource.tensorboard_controller_manifests_priority_3
  ]
}

resource "kustomization_resource" "training_operator_manifests_priority_3" {
  for_each = data.kustomization_build.training_operator.ids_prio[2]
  manifest = data.kustomization_build.training_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.training_operator_manifests_priority_1,
    kustomization_resource.training_operator_manifests_priority_2,
    kustomization_resource.tensorboard_controller_manifests_priority_1,
    kustomization_resource.tensorboard_controller_manifests_priority_2,
    kustomization_resource.tensorboard_controller_manifests_priority_3
  ]
}
