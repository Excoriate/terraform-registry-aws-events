package sns_topic

import (
	"testing"

	"github.com/Excoriate/tftest/pkg/scenario"
	"github.com/stretchr/testify/assert"
)

func TestSimpleOptionsPlanScenario(t *testing.T) {
	//s, err := scenario.New("simple_options_plan_scenario.tf")
	s, err := scenario.New(t, "../../data/sns-topic")
	assert.NoErrorf(t, err, "Failed to create scenario: %s", err)

	//s.Stg.PlanStage(t, s.GetTerraformOptions())
}
