import React from 'react'
import PropTypes from 'prop-types'

function TestComp(props) {
  return(
      <div>
        <p>{props.message}</p>
      </div>
  )
}

TestComp.propTypes = {
  message: PropTypes.string
}

export default TestComp